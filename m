Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267259AbSKPJfW>; Sat, 16 Nov 2002 04:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbSKPJfW>; Sat, 16 Nov 2002 04:35:22 -0500
Received: from mailhost2-bcvloh.bcvloh.ameritech.net ([66.73.20.44]:15763 "EHLO
	mailhost.bcv2.ameritech.net") by vger.kernel.org with ESMTP
	id <S267259AbSKPJfV>; Sat, 16 Nov 2002 04:35:21 -0500
Message-ID: <3DD6130C.5070906@ameritech.net>
Date: Sat, 16 Nov 2002 03:42:36 -0600
From: watermodem <aquamodem@ameritech.net>
Reply-To: aquamodem@ameritech.net
Organization: not at all
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.20-rc2 compiler warning for irlan_client_event.c (__FUNCTION__)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irlan_client_event.c: In function `irlan_client_state_idle':
irlan_client_event.c:104: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
rm -f irlan.o

