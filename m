Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263828AbUFFRM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbUFFRM4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbUFFRM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:12:56 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:41900 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S263828AbUFFRMz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:12:55 -0400
Message-ID: <40C35091.8000902@dlfp.org>
Date: Sun, 06 Jun 2004 19:12:49 +0200
From: Benoit Dejean <TazForEver@dlfp.org>
Reply-To: TazForEver@free.fr
User-Agent: Mozilla Thunderbird 0.6 (X11/20040528)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, cyplp@free.fr
Subject: Re: [2.6.6 panic] via-rhine and acpi sleep 3
References: <40C314C4.4080006@dlfp.org> <200406061943.41009.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200406061943.41009.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko a écrit :
> 
> Retrieve it from your syslog

i'm afraid it's empty, nothin about the panic is saved there. i've tried 
to run a while:; do sync; done and to ajust  kernel log buffer size from 
  14 to 10 but i've not been able to retrieve anything

