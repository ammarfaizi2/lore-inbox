Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318356AbSHPN1d>; Fri, 16 Aug 2002 09:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318357AbSHPN1c>; Fri, 16 Aug 2002 09:27:32 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:30942 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318356AbSHPN1c>; Fri, 16 Aug 2002 09:27:32 -0400
Message-ID: <3D5CFE83.136D81FC@wanadoo.fr>
Date: Fri, 16 Aug 2002 15:30:43 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre2 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre2-ac3 stops responding
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've the followings symptoms 

My computer is a K6-2 500 with 384Mb SDRAM

1st time to boot:
-----------------
with 2.4.20-pre2 : 30s
with 2.4.30-pre2-ac3 : 55s

2nd while running:
------------------
If I have high disk activity, the system stops responding for a while,
it does not accepts any key action nor mouse movement. It starts running
normally after few seconds.

----
Regards
	Jean-Luc
