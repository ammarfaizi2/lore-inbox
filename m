Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbTF2Tdx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTF2Tdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:33:52 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:11550 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264932AbTF2Tct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:32:49 -0400
Date: Sun, 29 Jun 2003 15:45:41 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk>
To: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Message-id: <200306291545410600.02136814@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl>
 <20030629192847.GB26258@mail.jlokier.co.uk>
 <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 8:42 PM viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Sun, Jun 29, 2003 at 08:28:47PM +0100, Jamie Lokier wrote:
>> Consider that many people choose ext3 rather than reiser simply
>> because it is easy to convert ext2 to ext3, and hard to convert ext2
>> to reiser (and hard to convert back if they don't like it).  I have
>> seen this written by many people who choose to use ext3.  Thus proving
>> that there is value in in-place filesystem conversion :)
>
>Uh-huh.  You want to get in-kernel conversion between ext* and reiserfs?
>With recoverable state if aborted?  Get real.

no, in-kernel conversion between everything.  You don't think it can be done?
It's not that difficult a problem to manage data like that :D

