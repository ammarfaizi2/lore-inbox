Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268183AbUJDPGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268183AbUJDPGn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 11:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268168AbUJDPGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 11:06:43 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:35231 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268183AbUJDPGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 11:06:11 -0400
Date: Mon, 4 Oct 2004 08:04:10 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Ulrich Drepper <drepper@redhat.com>
cc: George Anzinger <george@mvista.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: Posix compliant cpu clocks V6 [2/3]: Glibc patch
In-Reply-To: <415E3D5A.2010501@redhat.com>
Message-ID: <Pine.LNX.4.58.0410040803460.6114@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
 <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
 <415AF4C3.1040808@mvista.com> <B6E8046E1E28D34EB815A11AC8CA31290322B307@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0410011259190.18738@schroedinger.engr.sgi.com>
 <415E3D5A.2010501@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2004, Ulrich Drepper wrote:

> Christoph Lameter wrote:
> > The following patch makes glibc not provide the above clocks and use the
> > kernel clocks instead if either of the following condition is met:
>
> Did you ever hear about a concept called binary compatiblity?  Don't
> bother working on any glibc patch.

I wonder what this is about?

