Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261643AbSJUU6u>; Mon, 21 Oct 2002 16:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSJUU6u>; Mon, 21 Oct 2002 16:58:50 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:14090 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S261643AbSJUU6t>;
	Mon, 21 Oct 2002 16:58:49 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: 2.5.44 console keyboard dead
Date: Mon, 21 Oct 2002 21:04:23 +0000 (UTC)
Organization: Cistron
Message-ID: <ap1q4m$dko$1@ncc1701.cistron.net>
References: <Pine.LNX.4.44.0210220434280.23048-100000@boston.corp.fedex.com>
X-Trace: ncc1701.cistron.net 1035234263 13976 62.216.30.38 (21 Oct 2002 21:04:23 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0210220434280.23048-100000@boston.corp.fedex.com>,
Jeff Chua  <jchua@fedex.com> wrote:
>I can't type anything on the console keyboard on 2.5.44
>rlogin works ok.

Please check the settings of serial support.
Only then you get the choice of different keyboard support
at the next question (enable at keyboard)

Got fooled by it too ;)

Danny


