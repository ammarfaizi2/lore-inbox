Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264672AbTFARLu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 13:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264674AbTFARLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 13:11:50 -0400
Received: from A17-250-248-97.apple.com ([17.250.248.97]:8176 "EHLO
	smtpout.mac.com") by vger.kernel.org with ESMTP id S264672AbTFARLt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 13:11:49 -0400
Date: Mon, 2 Jun 2003 03:24:08 +1000
Subject: Re: 2.5.70 and 2.5.70-mm3 hang on bootup
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: Bernhard Rosenkraenzer <bero@arklinux.org>
From: Stewart Smith <stewartsmith@mac.com>
In-Reply-To: <Pine.LNX.4.53.0306011742490.3125@dot.kde.org>
Message-Id: <DA599B16-9455-11D7-AF84-00039346F142@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, June 2, 2003, at 01:46  AM, Bernhard Rosenkraenzer wrote:
> Both 2.5.70 and 2.5.70-mm3 hang right after "Ok, booting the 
> kernel..." on
> one of my test boxes (at the point, nothing works, not even turning 
> on/off
> the NumLock LED).

Running -bk6 fixed this for me. bk5 might have worked as well, but by 
the time i'd built that, bk6 was out :)

------------------------------
Stewart Smith
stewartsmith@mac.com
Ph: +61 4 3884 4332
ICQ: 6734154
http://www.flamingspork.com/       http://www.linux.org.au

