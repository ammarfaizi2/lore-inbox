Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265025AbTGBPOm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 11:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbTGBPOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 11:14:42 -0400
Received: from lns-th2-5f-81-56-227-145.adsl.proxad.net ([81.56.227.145]:17280
	"EHLO smtp.ced-2.eu.org") by vger.kernel.org with ESMTP
	id S265025AbTGBPOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 11:14:41 -0400
Message-ID: <3F02FA3E.2080004@ifrance.com>
Date: Wed, 02 Jul 2003 17:29:02 +0200
From: =?ISO-8859-1?Q?C=E9dric?= <cedriccsm2@ifrance.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20030624
X-Accept-Language: fr-fr, fr, en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 cd-writer problem
References: <200307012029.h61KTUZk001416@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200307012029.h61KTUZk001416@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
>>I'm having trouble with my cd-writer :
>>It is recognized with linux 2.4.18, and isnt with 2.4.21. My box freeze 
>>at its detection.
>>I've tried ide-scsi, which complains about a timeout, and freeze too.
> 
> Have you tried any kernels between 2.4.18 and 2.4.21 to try to
> identify which change caused the problem?  Also, details of which IDE
> chipset you've got would be useful.

I've tried 2.4.20, and got the same freeze.
I didn't try 2.4.19.

My IDE chipset is VIA® VT8233A (associed with VIA® KT333)

-- 
Cédric

