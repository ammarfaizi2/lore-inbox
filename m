Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWDKPJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWDKPJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 11:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWDKPJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 11:09:51 -0400
Received: from test.estpak.ee ([194.126.115.47]:14554 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751350AbWDKPJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 11:09:50 -0400
From: Hasso Tepper <hasso@estpak.ee>
To: Jens Axboe <axboe@suse.de>
Subject: Re: cciss crash while executing hpacucli
Date: Tue, 11 Apr 2006 18:09:38 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200604081732.47528.hasso@estpak.ee> <20060411054143.GK3859@suse.de>
In-Reply-To: <20060411054143.GK3859@suse.de>
Organization: Elion Enterprises Ltd.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604111809.38956.hasso@estpak.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> This one finally got fixed, see Mike's posting from yesterday. Subject
> "[PATCH 1/1] cciss: bug fix for crash when running hpacucli"

I can confirm that it fixes the problem. Many thanks.


-- 
Hasso Tepper
