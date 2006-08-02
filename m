Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWHBGpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWHBGpN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 02:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWHBGpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 02:45:13 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:30394 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S1751209AbWHBGpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 02:45:11 -0400
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: Christoph Lameter <clameter@sgi.com>,
       Paul Davies <pauld@gelato.unsw.edu.au>
Date: Wed, 2 Aug 2006 16:44:53 +1000
Cc: Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Gerd Hoffmann <kraxel@suse.de>, Hollis Blanchard <hollisb@us.ibm.com>,
       Ian Pratt <ian.pratt@xensource.com>, Zachary Amsden <zach@vmware.com>,
       npiggin@suse.de
Subject: Re: [PATCH 1 of 13] Add apply_to_page_range() which applies a function to a pte range
Message-ID: <20060802064453.GA10986@cse.unsw.EDU.AU>
References: <79a98a10911fc4e77dce.1154421372@ezr.goop.org> <m1ejw0zmic.fsf@ebiederm.dsl.xmission.com> <20060801211410.GH2654@sequoia.sous-sol.org> <Pine.LNX.4.64.0608011421080.19146@schroedinger.engr.sgi.com> <1154492211.2570.43.camel@localhost.localdomain> <Pine.LNX.4.64.0608012214440.21242@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608012214440.21242@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 10:18:33PM -0700, Christoph Lameter wrote:
> I have not been involved in this issue for a long time now.
> You need to contact the people actively working on code like this. 
> Most important is likely Ian Wienand. 

Paul Davies <pauld@gelato.unsw.edu.au> is the person actively working
on this project.  I might note he has not been doing it un-announced;
see

http://marc.theaimsgroup.com/?l=linux-mm&m=115276500100695&w=2

for the latest patches, or some of the other links Cristoph pointed
out.  I'm sure he'd love to talk to anyone about it :)

-i
