Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273807AbRIRC3t>; Mon, 17 Sep 2001 22:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273809AbRIRC3j>; Mon, 17 Sep 2001 22:29:39 -0400
Received: from mail.fbab.net ([212.75.83.8]:33041 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S273807AbRIRC3U>;
	Mon, 17 Sep 2001 22:29:20 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: tomlins@cam.org linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 5.889943 secs)
Message-ID: <034b01c13fea$1764be60$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Ed Tomlinson" <tomlins@cam.org>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20010918031813.57E1062ABC@oscar.casa.dyndns.org>
Subject: Re: Linux 2.4.10-pre11
Date: Tue, 18 Sep 2001 04:31:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ed Tomlinson" <tomlins@cam.org>
> Hi,
> 
> You are fast.  Was just going report this one...
> Using debian sid with gcc 2.95.4.  Both before and after
> appling the patch below I get:
> 


The patch seems wrong...
The files include "compile.h", but should include "compiler.h", no?

Magnus


