Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262781AbVBYWUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbVBYWUj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 17:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbVBYWUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 17:20:39 -0500
Received: from web50203.mail.yahoo.com ([206.190.38.44]:48977 "HELO
	web50203.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262781AbVBYWU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 17:20:27 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=E/NT/1hwgzvxCUkVoCle8q0G6NNi9XFr0XjrRhM0mBZIwVLOjk3eiET0kb465MSsaZoz8DR+iUP9p20xK81zwuCm3G3eu5NkywYOOdkP5r2jeJiwNOA/qhLNos5W+drFlCeUar6zc92s+FaqLzFBczee15F57fntQtJd8gh7KFo=  ;
Message-ID: <20050225222022.77009.qmail@web50203.mail.yahoo.com>
Date: Fri, 25 Feb 2005 14:20:21 -0800 (PST)
From: Johan Braennlund <johan_brn@yahoo.com>
Subject: Re: ALPS touchpad not seen by 2.6.11 kernels
To: linux-kernel@vger.kernel.org
In-Reply-To: <d120d500050225134468f8ffac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Dmitry Torokhov wrote:

> Does i8042 detect presence of an AUX port (check dmesg)? 

No.

> If not try booting with i8042.noacpi kernel boot option.

Yes, that helped - everything's working now. Thank you.

- Johan


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
