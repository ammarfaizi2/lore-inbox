Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289139AbSAMMG1>; Sun, 13 Jan 2002 07:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289148AbSAMMGS>; Sun, 13 Jan 2002 07:06:18 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:58252 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289139AbSAMMGE>; Sun, 13 Jan 2002 07:06:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: 520047054719-0001@t-online.de (Oliver Neukum)
Reply-To: Oliver.Neukum@lrz.uni-muenchen.de
To: linux-kernel@vger.kernel.org
Subject: ugly warnings with likely/unlikely
Date: Sun, 13 Jan 2002 13:05:13 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16PjOb-0oLbCCC@fwd11.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

if (likely(stru->pointer))

results in an ugly warning about using pointer as int.
Is there something that could be done against that ?

	Regards
		Oliver
