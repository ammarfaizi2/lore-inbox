Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281461AbRKFEwh>; Mon, 5 Nov 2001 23:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281460AbRKFEw1>; Mon, 5 Nov 2001 23:52:27 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26359
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281459AbRKFEwO>; Mon, 5 Nov 2001 23:52:14 -0500
Date: Mon, 5 Nov 2001 20:52:07 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: CMC <cmc@jncasr.ac.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crash due to kernel bug
Message-ID: <20011105205207.A677@mikef-linux.matchmail.com>
Mail-Followup-To: CMC <cmc@jncasr.ac.in>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111061018540.6335-100000@mercury.intranet.jncasr.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111061018540.6335-100000@mercury.intranet.jncasr.ac.in>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2001 at 10:21:48AM +0530, CMC wrote:
> 
> The RH7.1 system with 2.4.2 kernel crashed and the /var/log/messages had
> this report.
> 

Filter it through ksymoops with the correct System.map file and resend.

Can you reproduce with a newer kernel?
