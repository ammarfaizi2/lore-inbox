Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVAaKpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVAaKpq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 05:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVAaKpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 05:45:45 -0500
Received: from ext-ch1gw-1.online-age.net ([216.34.191.35]:49290 "EHLO
	ext-ch1gw-1.online-age.net") by vger.kernel.org with ESMTP
	id S261782AbVAaKpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 05:45:41 -0500
From: "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 31 Jan 2005 11:45:32 +0100
Subject: How peek at tcp socket data w/o reading it
Message-ID: <20050131104532.GA3208@wszip-kinigka.euro.med.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

hack wanted:

is it possible to peek a few bytes from a tcp socket which is
ready to read without actually reading the data? (or some
means to push already read data back similar to ungetc)

Any creative ideas welcome.

Karl
-- 
Karl Kiniger   mailto:karl.kiniger@med.ge.com
GE Medical Systems Kretztechnik GmbH & Co OHG
Tiefenbach 15       Tel: (++43) 7682-3800-710
A-4871 Zipf Austria Fax: (++43) 7682-3800-47
