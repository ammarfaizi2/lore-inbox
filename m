Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWCXPof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWCXPof (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWCXPof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:44:35 -0500
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:11436 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750976AbWCXPoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:44:34 -0500
Date: Fri, 24 Mar 2006 10:44:29 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Arjan van de Ven <arjan@infradead.org>
cc: yang.y.yi@gmail.com, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Matt Helsley <matthltc@us.ibm.com>
Subject: Re: Connector: Filesystem Events Connector v3
In-Reply-To: <1143210523.2882.74.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0603241044080.26833@excalibur.intercode>
References: <4423673C.7000008@gmail.com>  <1143183541.2882.7.camel@laptopd505.fenrus.org>
  <4c4443230603240624g132b8d37t1a271a8303b810bf@mail.gmail.com>
 <1143210523.2882.74.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2006, Arjan van de Ven wrote:

> > > > big overhead for the whole system,
> > >
> > > this is not true
> > Hmm, Why?
> 
> audit only audits those syscalls (or rather, operations) you enable it
> to audit basically.

Exactly, which takes about 2 minutes of code reading to discover.


- James
-- 
James Morris
<jmorris@namei.org>
