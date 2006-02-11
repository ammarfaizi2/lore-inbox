Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWBKBIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWBKBIf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 20:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWBKBIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 20:08:35 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:9641 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751224AbWBKBIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 20:08:35 -0500
Date: Sat, 11 Feb 2006 02:08:28 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: "hackmiester (Hunter Fuller)" <hackmiester@hackmiester.com>
Cc: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: CD-blanking leads to machine freeze with current -git [was: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]]
Message-ID: <20060211010828.GB5684@stiffy.osknowledge.org>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <20060210175848.GA5533@stiffy.osknowledge.org> <43ECE734.5010907@cfl.rr.com> <20060210210006.GA5585@stiffy.osknowledge.org> <43ED37E2.3060800@hackmiester.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ED37E2.3060800@hackmiester.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g25bf368b-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* hackmiester (Hunter Fuller) <hackmiester@hackmiester.com> [2006-02-10 19:03:30 -0600]:

> Hrm. ssh into the box and then try to blank the CD on the local machine. 
> Is the ssh session still responsive? I suspect it will be, especially if 
> the GNOME clock's still running.

The clock stopped working after a while. I guess sshd would just 'die away' as
any other process did in that case. I'll try with the flag set as Alan suggested.

Marc
