Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbUKXPEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbUKXPEa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 10:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbUKXPCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 10:02:39 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:19521 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262679AbUKXPCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 10:02:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=trwfynj3rRgykVfTvPX3w8wqXeRK6QBUUABilh76mG7C12UvfH7ch3NPdMfeOZX8dOzZMRORFiPXH4Gd44q084eW4mmh8zVzr2T3F/AttP5ctBzl80Sf8h/x7EiBzCbGfXSFEGfrUTbtY4udnqfsD32kmaml9SXsmIr1Wg0Tn7M=
Message-ID: <4d8e3fd304112407023ff0a33d@mail.gmail.com>
Date: Wed, 24 Nov 2004 16:02:05 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Peter Foldiak <peter.foldiak@st-andrews.ac.uk>
Subject: Re: file as a directory
Cc: Hans Reiser <reiser@namesys.com>, Tomas Carnecky <tom@dbservice.com>,
       Helge Hafting <helge.hafting@hist.no>, Amit Gud <amitgud1@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
In-Reply-To: <1101287762.1267.41.camel@pear.st-and.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2c59f00304112205546349e88e@mail.gmail.com>
	 <41A1FFFC.70507@hist.no> <41A21EAA.2090603@dbservice.com>
	 <41A23496.505@namesys.com>
	 <1101287762.1267.41.camel@pear.st-and.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Nov 2004 09:16:03 +0000, Peter Foldiak
<peter.foldiak@st-andrews.ac.uk> wrote:
[...] 
> I would really like to implement this for the next version of Hans' file
> system.

I don't undersand how you want to use Xpath for not XML file.
I agree with you that the idea behind Xpath is cool but I fail to
unserstand how it can be applied to anything but XML

-- 
Paolo
Picasa users groups: www.picasa-users.tk
join the blog group: http://groups-beta.google.com/group/blog-users
