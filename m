Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288279AbSACSxw>; Thu, 3 Jan 2002 13:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288289AbSACSxm>; Thu, 3 Jan 2002 13:53:42 -0500
Received: from dsl-213-023-043-223.arcor-ip.net ([213.23.43.223]:16655 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288279AbSACSxi>;
	Thu, 3 Jan 2002 13:53:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jonathan Corbet <corbet-lk@lwn.net>, davej@suse.de
Subject: Re: [PATCH] Fix kdev_t in sr, st, sg
Date: Thu, 3 Jan 2002 19:56:56 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020103184523.6115.qmail@eklektix.com>
In-Reply-To: <20020103184523.6115.qmail@eklektix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16MD2v-00019g-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 3, 2002 07:45 pm, Jonathan Corbet wrote:
> Here's a patch against 2.5.1-dj11 which fixes the kdev_t compilation
> problems in the SCSI tape, CD, and generic modules.  Tape and CD are tested
> and work; I've not had a chance to actually *run* anything that uses sg
> yet, but it "looks like it should work."
> 
> I have a 2.5.2-pre6 version that I'll send out shortly.

Hi,

Hey, wow, you've got time to hack and still keep grinding out the deathless 
prose?

/me figures next Zack Brown will show up with a patch

--
Daniel
