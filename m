Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264875AbTL0WsZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 17:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264877AbTL0WsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 17:48:25 -0500
Received: from 82-43-130-207.cable.ubr03.mort.blueyonder.co.uk ([82.43.130.207]:53645
	"EHLO efix.biz") by vger.kernel.org with ESMTP id S264875AbTL0WsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 17:48:23 -0500
Subject: Re: OSS sound emulation broken between 2.6.0-test2 and test3
From: Edward Tandi <ed@efix.biz>
To: Henrik Storner <henrik-kernel@hswn.dk>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <bskv6j$aje$1@ask.hswn.dk>
References: <1072535590.12308.250.camel@nosferatu.lan>
	 <1080000.1072475704@[10.10.2.4]>	 <1072479167.21020.59.camel@nosferatu.lan>
	 <1480000.1072479655@[10.10.2.4]> <1072480660.21020.64.camel@nosferatu.lan>
	 <1640000.1072481061@[10.10.2.4]> <1072482611.21020.71.camel@nosferatu.lan>
	 <2060000.1072483186@[10.10.2.4]>	 <1072500516.12203.2.camel@duergar>
	 <8240000.1072511437@[10.10.2.4]> <1072523478.12308.52.camel@nosferatu.lan>
	 <1072525450.3794.8.camel@wires.home.biz>
	 <1072527874.12308.100.camel@nosferatu.lan>
	 <1072530488.2906.1.camel@wires.home.biz>
	 <1072535590.12308.250.camel@nosferatu.lan>
	 <1072544151.8611.18.camel@wires.home.biz>  <bskv6j$aje$1@ask.hswn.dk>
Content-Type: text/plain
Message-Id: <1072565484.2698.9.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2mdk 
Date: Sat, 27 Dec 2003 22:51:25 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-27 at 21:56, Henrik Storner wrote:
> In <1072544151.8611.18.camel@wires.home.biz> Edward Tandi <ed@efix.biz> writes:
> 
> >I would say the symptoms are that the music starts playing OK bit after
> >a short period (18-19 seconds), the music changes overall speed (by a
> >semi-tone or so). When it does this, the sound also starts to break up.
> 
> Just a "me too" post - I've been trying out 2.6.0 over the past couple
> of days, and this is the only real issue I've encountered. Just like
> you describe, the pace of the music playing speeds up slightly, and
> there are some mis-sounds for a few seconds. Then it comes back to
> normal.

Yes, it lasts for about 5 seconds then continues as normal. The problem
then re-occurs about 1.5-2.5 minutes after that. The recurrence after
that becomes harder to predict.

Interestingly, if you leave XMMS playing long enough (over an hour) such
as listening to a vorbis radio stream, it finally goes into permanent
break-up mode. It's so bad that you really have to stop playing and
start again (no need to shut down XMMS though).

Ed-T.


