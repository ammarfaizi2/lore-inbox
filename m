Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131792AbRBWTU1>; Fri, 23 Feb 2001 14:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131789AbRBWTUS>; Fri, 23 Feb 2001 14:20:18 -0500
Received: from sttlpop4.sttl.uswest.net ([206.81.192.4]:31763 "HELO
	sttlpop4.sttl.uswest.net") by vger.kernel.org with SMTP
	id <S131758AbRBWTT6>; Fri, 23 Feb 2001 14:19:58 -0500
From: Steven King <sxking@uswest.net>
Reply-To: sxking@uswest.net
Organization: is the root of all evil
Date: Fri, 23 Feb 2001 11:19:46 -0800
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
To: " Mohammad A. Haque" <mhaque@haque.net>,
        " " <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.32.0102231346350.32010-100000@viper.haque.net>
In-Reply-To: <Pine.LNX.4.32.0102231346350.32010-100000@viper.haque.net>
Subject: Re: loop-6 patch and 2.4.2
MIME-Version: 1.0
Message-Id: <01022311194600.00869@rigel>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 February 2001 10:50, 	Mohammad A. Haque wrote:
> Is anyone else using 2.4.2 patched with loop-6? Does load goto about 1
> and stay there even though mounting things via loop seem to work fine?

  Yes, and with 2 mounts the load avg goes ~2; after umounting, it goes back 
to normal levels.
