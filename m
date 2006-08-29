Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbWH2QNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWH2QNd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbWH2QNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:13:33 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:12174 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965046AbWH2QNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:13:32 -0400
Date: Tue, 29 Aug 2006 09:12:24 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Dong Feng <middle.fengdong@gmail.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Paul Mackerras <paulus@samba.org>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: The 3G (or nG) Kernel Memory Space Offset
In-Reply-To: <a2ebde260608290901w73575e18hffd8a9d6c989f523@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0608290908500.18149@schroedinger.engr.sgi.com>
References: <a2ebde260608290715o627c631uca67e5b84b8c0777@mail.gmail.com> 
 <Pine.LNX.4.61.0608291634380.16371@yvahk01.tjqt.qr>
 <a2ebde260608290901w73575e18hffd8a9d6c989f523@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006, Dong Feng wrote:

> Or perhaps this offset is just some personal favor. Say if the first
> kernel designer decided to locate kernel at 2-3G linear address, then
> 2G offset would have appeared in code. Is this the case?

Well this is the second time that you suggest that the reason for 
technical decisions have to do with personal favors. Are you trying to 
provoke us into answering your question?

