Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318518AbSHLAzp>; Sun, 11 Aug 2002 20:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318529AbSHLAzp>; Sun, 11 Aug 2002 20:55:45 -0400
Received: from fmr05.intel.com ([134.134.136.6]:33779 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S318518AbSHLAzo>; Sun, 11 Aug 2002 20:55:44 -0400
X-Uptime: 9:54am  up 62 days, 23:47,  1 user,  load average: 0.02, 0.01, 0.00
X-OS: Linux hazuki 2.4.17 #5 SMP Tue Feb 19 12:06:25 JST 2002 i686 unknown
To: "Michel Eyckmans (MCE)" <mce@pi.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.31: modules don't work at all
References: <200208111241.g7BCfakl018731@jebril.pi.be>
X-Organization: IOS
X-Disclaimer: My opinions do not necessarily represent anything ...err those of my employer
Content-Type: text/plain; charset=US-ASCII
From: ryan.flanigan@intel.com (Flanigan, Ryan)
Date: 12 Aug 2002 09:54:11 +0900
In-Reply-To: "Michel Eyckmans's message of "Sun, 11 Aug 2002 14:41:36 +0200"
Message-ID: <87y9bcvqvg.fsf@hazuki.jp.intel.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Michel" == Michel Eyckmans <(MCE)" <mce@pi.be>> writes:

    Michel> After upgrading from 2.5.30 to 2.5.31, nothing related to
    Michel> modules works for me. Insmod, rmmod, you name it. They all
    Michel> cause errors along the line of: "QM_SYMBOLS: Bad
    Michel> Address". Any suggestions?
 
is CONFIG_PREEMPT set?
