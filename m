Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281761AbRKZPQc>; Mon, 26 Nov 2001 10:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281763AbRKZPQM>; Mon, 26 Nov 2001 10:16:12 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:51686 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S281761AbRKZPQL>; Mon, 26 Nov 2001 10:16:11 -0500
X-Gnus-Agent-Meta-Information: mail nil
From: Christoph Rohland <cr@sap.com>
To: god@yinyang.hjsoft.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Severe Linux 2.4 kernel memory leakage
In-Reply-To: <Pine.LNX.4.40.0111251053390.7809-100000@yinyang.hjsoft.com>
Organisation: SAP LinuxLab
In-Reply-To: <Pine.LNX.4.40.0111251053390.7809-100000@yinyang.hjsoft.com>
Message-ID: <m3g0716hog.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
Date: 26 Nov 2001 16:11:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shannon,

On Sun, 25 Nov 2001, Shannon Aldinger wrote:
> Are you using tmpfs, that had problems in the earlier 2.4.x's IIRC.

tmpfs always shows up as cached (stock) or shared (in -ac)

Greetings
		Christoph


