Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbTDTV1X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 17:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263712AbTDTV1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 17:27:23 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:20897 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S263711AbTDTV1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 17:27:22 -0400
Date: Sun, 20 Apr 2003 23:38:00 +0200
From: bert hubert <ahu@ds9a.nl>
To: Seth Britten Chandler <sethbc@WPI.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem opening slave tty's in 2.5.68{-mm1}
Message-ID: <20030420213800.GA9695@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Seth Britten Chandler <sethbc@WPI.EDU>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0304201734080.25559-100000@ccc9.WPI.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304201734080.25559-100000@ccc9.WPI.EDU>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 20, 2003 at 05:35:45PM -0400, Seth Britten Chandler wrote:
> i'm sure this has already been covered, but i've had problmes with my mail
> recently.  Every time i try to open an {A,E,x}term i get

Read the stuff about devfs and ptyfs - Linus mentioned it in the
announcement.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
