Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTKYJHg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 04:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbTKYJHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 04:07:36 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:17647 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id S262129AbTKYJHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 04:07:32 -0500
Date: Tue, 25 Nov 2003 04:07:27 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Copy protection of the floppies
Message-ID: <20031125090727.GA1560@Master>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <5F0021EEA434D511BE7300D0B7B6AB530CA67677@mail2.ggn.hcltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F0021EEA434D511BE7300D0B7B6AB530CA67677@mail2.ggn.hcltech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 11:07:29AM +0530, Pravin Nanaware , Gurgaon wrote:
> Hi All,
> 
> 1> Could somebody suggest me the way to protect floppy from copying it's
> contents. 
> 2> If not possible, will it be possible to make the copied floppy unworkable
> (The copied floppy shouldn't work).  
>    For this I have constraint, I don't want to change the platform, which
> reads this floppy.
> 
> 
> The contents of the floppy could be anything like text file, exe file or
> encrypted file.

Encrypt the data. That's the only way that actually works. 

-- 
Murray J. Root

