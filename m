Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267978AbTAHXb1>; Wed, 8 Jan 2003 18:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267979AbTAHXb1>; Wed, 8 Jan 2003 18:31:27 -0500
Received: from [213.171.53.133] ([213.171.53.133]:55562 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S267978AbTAHXb0>;
	Wed, 8 Jan 2003 18:31:26 -0500
Date: Thu, 9 Jan 2003 02:40:07 +0300 (MSK)
From: "Ruslan U. Zakirov" <cubic@miee.ru>
To: linux-kernel@vger.kernel.org
Subject: [2.5.54] Oops generating problem.
Message-ID: <Pine.BSF.4.05.10301090229520.91414-100000@wildrose.miee.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello All!
Oops printing mechanism have been broken to me in 2.5.54.
Under 2.5.5[0-3] I've got oops messages, but now it's printing
few first strings of message then printing going to loop with same
strings and after some time machine reboots. 
		Ruslan.

