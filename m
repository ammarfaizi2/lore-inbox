Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVA1CZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVA1CZU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 21:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVA1CZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 21:25:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22689 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261394AbVA1CZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 21:25:16 -0500
Date: Thu, 27 Jan 2005 21:25:14 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Nigel Cunningham <ncunningham@linuxmail.org>
cc: Jasper Spaans <jasper@vs19.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ajgrothe@yahoo.com>
Subject: Re: crypto algoritms failing?
In-Reply-To: <1106876975.15806.42.camel@nigelcunningham>
Message-ID: <Xine.LNX.4.44.0501272124120.7733-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005, Nigel Cunningham wrote:

> You normally test cryptoapi functionality while booting?

This happens if you link tcrypt statically into the kernel.


- James
-- 
James Morris
<jmorris@redhat.com>


