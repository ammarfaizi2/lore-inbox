Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbTCPRCR>; Sun, 16 Mar 2003 12:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262693AbTCPRCR>; Sun, 16 Mar 2003 12:02:17 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:45319 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262692AbTCPRCR>; Sun, 16 Mar 2003 12:02:17 -0500
Message-ID: <3E74B108.1010605@aitel.hist.no>
Date: Sun, 16 Mar 2003 18:14:48 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Maxime <x@organigramme.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: make bzImage fails when LANG set
References: <3E74AC1C.8010901@organigramme.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime wrote:

> Notice it is in french.  I search on the web for similar problem, and 
> find a few examples, all in foreing language.  Nobody seemed to know how 
> to solve this.  I then remembered I added these lines to my /etc/profile:
> 
> export LANG=fr
> export LC_ALL=fr_CA
> 
> By removing them, the kernel compiled just fine.  Stange bug!
> 
Strange indeed. I never had any problems compiling with LANG=no_NO
I don't set LC_ALL though.

Helge Hafting

