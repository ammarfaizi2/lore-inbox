Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270467AbRH1I5u>; Tue, 28 Aug 2001 04:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270469AbRH1I5k>; Tue, 28 Aug 2001 04:57:40 -0400
Received: from nella-b0-a.infonet.cz ([212.71.188.65]:23304 "EHLO
	mite.infonet.cz") by vger.kernel.org with ESMTP id <S270467AbRH1I5e>;
	Tue, 28 Aug 2001 04:57:34 -0400
Message-ID: <3B8B5D08.3020005@infonet.cz>
Date: Tue, 28 Aug 2001 10:57:44 +0200
From: Marian Jancar <marian.jancar@infonet.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.7 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: cs, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: spin_lock_bh for 2.2
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Im trying to port orinoco_cs driver to 2.2, using kcompat24 from bttv it is 
pretty easy except it doesnt contain spin_lock_bh emulation. Could someone 
give some hints or pointers to information how to do that?

Marian Jancar

