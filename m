Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267772AbUHFI0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267772AbUHFI0t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 04:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUHFI0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 04:26:48 -0400
Received: from [213.146.154.40] ([213.146.154.40]:1436 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S267772AbUHFIYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 04:24:21 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: David Woodhouse <dwmw2@infradead.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: axboe@suse.de, kernel@wildsau.enemy.org, linux-kernel@vger.kernel.org
In-Reply-To: <200408060814.i768E3Pw005213@burner.fokus.fraunhofer.de>
References: <200408060814.i768E3Pw005213@burner.fokus.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1091780651.4383.4702.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 06 Aug 2004 09:24:11 +0100
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-06 at 10:14 +0200, Joerg Schilling wrote:
> Before you are making the wrong conclsuions, I encourage you to read RFC-2822
> and to find somebody who is able to explain you the difference between the
> words "must" and "should" when used in standards....

Actually I don't need to find somebody to explain it to me. RFC 2119
makes it very clear:

3. SHOULD   This word, or the adjective "RECOMMENDED", mean that there
   may exist valid reasons in particular circumstances to ignore a
   particular item, but the full implications must be understood and
   carefully weighed before choosing a different course.

Would you care to explain what valid reasons you have for ignoring
§3.6.4 of RFC2822, and why those override the implications of doing so
(which, as stated, is that you break the threading of your replies and
cause the signal:noise ratio to degrade).

-- 
dwmw2

