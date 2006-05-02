Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751530AbWEETDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbWEETDk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 15:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbWEETDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 15:03:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63643 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751507AbWEETDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 15:03:39 -0400
Date: Tue, 2 May 2006 08:42:52 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Circuitsoft Development <circuitsoft.devel@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Extended Volume Manager API
In-Reply-To: <64b292120605011310n59ac3bdew2508bfa8b923adb3@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0605020842250.29285@cuia.boston.redhat.com>
References: <64b292120604302226i377f1c37qd33db36693ea1871@mail.gmail.com> 
 <200605010702.k4172Q5H006348@turing-police.cc.vt.edu> 
 <64b292120605010759h4d9c74d7s717d125018ab95d3@mail.gmail.com>
 <64b292120605011310n59ac3bdew2508bfa8b923adb3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 May 2006, Circuitsoft Development wrote:

> I was actually planning on a 5msec timeout to ignore that computer,
> for now, then if I don't get a response within 100msec,  ping them,
> and permenantly remove them from the list of peers and broadcast a
> "this peer is dead" message to the network if the ping times out at
> 500msec.

How are you going to prevent your "dead" peer from writing
to the disk anyway ?

-- 
All Rights Reversed
