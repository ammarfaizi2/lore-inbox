Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287537AbRLaPFa>; Mon, 31 Dec 2001 10:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287534AbRLaPFV>; Mon, 31 Dec 2001 10:05:21 -0500
Received: from mout04.kundenserver.de ([195.20.224.89]:22062 "EHLO
	mout04.kundenserver.de") by vger.kernel.org with ESMTP
	id <S287532AbRLaPFL>; Mon, 31 Dec 2001 10:05:11 -0500
Date: Mon, 31 Dec 2001 14:29:01 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fully preemptible kernel
Message-ID: <20011231132901.GA270@elfie.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <1007930466.11789.2.camel@phantasy> <1009396922.1678.9.camel@voyager.rueb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1009396922.1678.9.camel@voyager.rueb.com>
User-Agent: Mutt/1.3.24-current-20011230i (Linux 2.4.17-spc i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Dec 26 2001, Steve Bergman wrote:

[Preempt-kernel patch for 2.4.17 final]
> I just compiled 2.4.17 with the patch from your site that looks to be
> for 2.4.17-final.  Unfortunately, several modules (e.g. unix.o) fail on
> load with an undefined symbol error (preempt_schedule).

No problems here. Are you shure you built the kernel modules and they were
installed properly?

-- 
# Heinz Diehl, 68259 Mannheim, Germany
