Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWAIOvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWAIOvu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 09:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWAIOvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 09:51:50 -0500
Received: from terrhq.ru ([81.222.97.18]:54507 "EHLO mail.terrhq.ru")
	by vger.kernel.org with ESMTP id S932307AbWAIOvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 09:51:49 -0500
From: Yaroslav Rastrigin <yarick@it-territory.ru>
Organization: IT-Territory 
To: Lee Revell <rlrevell@joe-job.com>
Subject: [OT?] Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Date: Mon, 9 Jan 2006 17:51:27 +0300
User-Agent: KMail/1.9
References: <174467f50601082354y7ca871c7k@mail.gmail.com> <200601091403.46304.yarick@it-territory.ru> <1136814862.9957.5.camel@mindpipe>
In-Reply-To: <1136814862.9957.5.camel@mindpipe>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601091751.27405.yarick@it-territory.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lee,
On 9 January 2006 16:54, you wrote:
> > 
> 
> Where are the bug reports?  You didn't expect these to just fix
> themselves did you?
Been there, done that. Bugreport about malfunctioning (due to ACPI) 3c556 in IBM ThinkPad T20 was looked at once in a few months without any progress, 
and I've finally lost track of it after changing hardware. In more than a year this problem wasn't solved, so I'm assuming bugreports aren't so effective.
2200BG ping and packet loss problem was reported in ipw2200-devel mailing list recently (by another user), and the only answer was 
"Switch to version 1.0.0" (which is tooo old and missing needed features and bugfixes, so recommentation was unacceptable). So I'm assuming addressing 
developers directly is not too effective either. 
Two other options I see are to debug/fix it by myself and try to stimulate others monetarily. First option isn't really affordable for me , 
so I'm trying to research second. 
-- 
Managing your Territory since the dawn of times ...
