Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292377AbSB0Qwj>; Wed, 27 Feb 2002 11:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292801AbSB0Qw3>; Wed, 27 Feb 2002 11:52:29 -0500
Received: from fwext.dif.dk ([130.227.136.2]:62457 "EHLO DIFPST1A.dif.dk")
	by vger.kernel.org with ESMTP id <S292797AbSB0QwO>;
	Wed, 27 Feb 2002 11:52:14 -0500
Subject: Re: ISO9660 bug and loopback driver bug - a bigger problem then it
	would appear?
From: Jesper Juhl <jju@dif.dk>
To: root@chaos.analogic.com
Cc: barubary@cox.net, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020227092650.12981A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020227092650.12981A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 27 Feb 2002 17:54:24 +0100
Message-Id: <1014828869.6899.0.camel@jju_lnx>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-02-27 at 15:29, Richard B. Johnson wrote:
> On Wed, 27 Feb 2002, Jesper Juhl wrote:
> [SNIPPED year 2100 "bug"]
> [SNIPPED year 2100 "bug" --fix!]
> 
> > 
> > If the above is indeed correct, wouldn't it then be better to just do 
> > those changes in 2.5.x instead of 2.4.x (and then maybe backport them 
> > later)...
> 
> I suggest the changes wait until Version 99.99.  Many of the File Systems
> affected won't even exist 98 years from now -and an 'int' will probably
> be 256 bits.
> 

Sure ;)  I'll just leave it alone for now. Maybe later if things change
it can be fixed without requireing major changes.


-- 
Mvh. / Best regards
Jesper Juhl - jju@dif.dk


