Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132939AbRDUVro>; Sat, 21 Apr 2001 17:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132940AbRDUVrf>; Sat, 21 Apr 2001 17:47:35 -0400
Received: from paloma12.e0k.nbg-hannover.de ([62.159.219.12]:56742 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S132939AbRDUVrW>; Sat, 21 Apr 2001 17:47:22 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Tim Wilson <timwilson@mediaone.net>
Subject: Re: [PATCH] ppp_generic, kernel 2.4.
Date: Sun, 22 Apr 2001 00:12:15 +0200
X-Mailer: KMail [version 1.2]
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01042200121500.01138@SunWave1>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tim,

it seems to me to that there is one little commentary close (*/) to much.


+   * A ConfReq indicates what the sender would like to receive */
+   */

should be


+   * A ConfReq indicates what the sender would like to receive
+   */

Have a nice weekend.

-Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
