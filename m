Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWCVTgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWCVTgy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 14:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWCVTgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 14:36:54 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:43392 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932422AbWCVTgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 14:36:53 -0500
Date: Wed, 22 Mar 2006 11:37:09 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 25/35] Add Xen time abstractions
Message-ID: <20060322193709.GE15997@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063800.241815000@sorel.sous-sol.org> <1143016720.2955.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143016720.2955.17.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven (arjan@infradead.org) wrote:
> Duplication like this is evil because it means too many places need
> duplicated bugfixes and rework (and such rework is underway)

Yes, that one is already on the todo list.  Will work on consolidation
there.

thanks,
-chris
