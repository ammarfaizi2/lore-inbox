Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268343AbUHKXwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268343AbUHKXwz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268352AbUHKXpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:45:18 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:57270 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S268313AbUHKX3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:29:37 -0400
Subject: Re: Finding out what certain kernel config options are dependant on
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Tim Cambrant <tcambrant@hotmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040810144200.GN26174@fs.tum.de>
References: <BAY1-F15JkUwWpSWerO0001ad67@hotmail.com>
	 <20040810144200.GN26174@fs.tum.de>
Content-Type: text/plain
Message-Id: <1092266784.1438.4377.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 12 Aug 2004 00:26:24 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 16:42 +0200, Adrian Bunk wrote:
>   find . -name Kconfig\* | xargs grep select | grep CRYPTO

Aunt Tillie's gonna fscking _love_ this :)

-- 
dwmw2


