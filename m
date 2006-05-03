Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbWECGQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbWECGQk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 02:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbWECGQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 02:16:40 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:3733 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965099AbWECGQj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 02:16:39 -0400
Date: Wed, 3 May 2006 09:16:35 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Francois Romieu <romieu@fr.zoreil.com>
cc: David Vrabel <dvrabel@cantab.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net
Subject: Re: [PATCH 2/2] ipg: redundancy with mii.h
In-Reply-To: <20060502215559.GA1119@electric-eye.fr.zoreil.com>
Message-ID: <Pine.LNX.4.58.0605030913210.6032@sbz-30.cs.Helsinki.FI>
References: <1146306567.1642.3.camel@localhost> <20060429122119.GA22160@fargo>
 <1146342905.11271.3.camel@localhost> <1146389171.11524.1.camel@localhost>
 <44554ADE.8030200@cantab.net> <4455F1D8.5030102@cantab.net>
 <1146506939.23931.2.camel@localhost> <20060501231206.GD7419@electric-eye.fr.zoreil.com>
 <Pine.LNX.4.58.0605020945010.4066@sbz-30.cs.Helsinki.FI>
 <20060502214520.GC26357@electric-eye.fr.zoreil.com>
 <20060502215559.GA1119@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francois,

On Tue, 2 May 2006, Francois Romieu wrote:
> Btw the whole serie is available in branch 'netdev-ipg' at:
> git://electric-eye.fr.zoreil.com/home/romieu/linux-2.6.git
> 
> The interim steps may be useful if testing reveals something wrong
> (especially if it happens in a few weeks/months).

I have all the interim steps in a private git tree also. I asked for a 
kernel.org account so I could publish the tree. However, if you wish to 
maintain the tree, I can send you my patches so you can recreate the full 
history. The first steps were produced by quilt on the original 
out-of-tree driver, though, so they're probably not helpful.

					Pekka
