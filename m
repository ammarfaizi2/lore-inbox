Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136826AbREJQBb>; Thu, 10 May 2001 12:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136828AbREJQBW>; Thu, 10 May 2001 12:01:22 -0400
Received: from www.linux.org.uk ([195.92.249.252]:27664 "EHLO www.linux.org.uk")
	by vger.kernel.org with ESMTP id <S136826AbREJQBJ>;
	Thu, 10 May 2001 12:01:09 -0400
Date: Thu, 10 May 2001 17:00:39 +0100
From: Chris Dukes <pakrat@www.uk.linux.org>
To: Ed Tomlinson <tomlins@cam.org>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] IDE DMA timeouts and reiserfs stability
Message-ID: <20010510170039.C1112@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Ed Tomlinson <tomlins@cam.org>, reiserfs-list@namesys.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <01050923423500.00777@oscar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01050923423500.00777@oscar>; from tomlins@cam.org on Wed, May 09, 2001 at 11:42:35PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 11:42:35PM -0400, Ed Tomlinson wrote:
> Hi,
> 
> I am using 2.4.5-pre1.  Over the course of the last two weeks I have had
> DMA timeouts occur twice.  Both times corrupted my fs.  While this is not
> ideal, its not unexpected as things stand now.  I have seen at least three 
> other reports on lkml about errors of this type - suspect that 2.4's ide 
> is a little fragile in some corner cases...

Out of curiousity, can you reproduce the problem in a 2.4 kernel with 
Andre Hedrick's IDE patch for 2.4 applied? 
It works for me, but that's just me.
(ftp://ftp.kernel.org/pub/linux/kernel/people/hedrick/)

-- 
Chris Dukes
The more I administer Solaris the more I believe it deserves the reputation
HPUX has and vice versa. -- me.
