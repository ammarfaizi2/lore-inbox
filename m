Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267042AbSL3S0Q>; Mon, 30 Dec 2002 13:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267043AbSL3S0Q>; Mon, 30 Dec 2002 13:26:16 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:8592 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267042AbSL3S0N>;
	Mon, 30 Dec 2002 13:26:13 -0500
Subject: Re: nfsservctl documentation?
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OF0BDEC488.45CFEF00-ON87256C9F.0065D913@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Mon, 30 Dec 2002 10:34:35 -0800
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0 [IBM]|December 16, 2002) at
 12/30/2002 11:34:25
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Well you have the best documentation of all: the code itself. I did not
find anything else other than the man page when trying to undestand it but
the code was easy to follow.

Juan



|---------+---------------------------------->
|         |           Shaya Potter           |
|         |           <spotter@cs.columbia.ed|
|         |           u>                     |
|         |           Sent by:               |
|         |           linux-kernel-owner@vger|
|         |           .kernel.org            |
|         |                                  |
|         |                                  |
|         |           12/29/02 09:30 PM      |
|         |                                  |
|---------+---------------------------------->
  >-------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                         |
  |       To:       linux-kernel@vger.kernel.org                                                                            |
  |       cc:                                                                                                               |
  |       Subject:  nfsservctl documentation?                                                                               |
  |                                                                                                                         |
  >-------------------------------------------------------------------------------------------------------------------------|




is there any real documentation on this syscall anywhere?  i.e. if one
wanted to write a daemon that dynamically dealt with nfs exports
(creating/removing/changing) this syscall would seem very appropriate
(at least as I understand), but I can't find any documentation besides
the skimpy man page on how to use it.

am I not supposed to use it? :)

thanks,

shaya

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



