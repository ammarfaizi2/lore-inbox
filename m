Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUG1TJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUG1TJh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 15:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUG1TJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 15:09:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55786 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262574AbUG1TJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 15:09:31 -0400
Date: Wed, 28 Jul 2004 15:09:13 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Robert Olsson <Robert.Olsson@data.slu.se>
cc: Pasi Sjoholm <ptsjohol@cc.jyu.fi>, Francois Romieu <romieu@fr.zoreil.com>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <16647.61953.158512.433946@robur.slu.se>
Message-ID: <Xine.LNX.4.44.0407281508450.12082-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004, Robert Olsson wrote:

> And maybe we should take the experiment disussions off the list.

This is what netdev is for :-)


- James
-- 
James Morris
<jmorris@redhat.com>


