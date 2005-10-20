Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVJTPbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVJTPbE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 11:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVJTPbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 11:31:04 -0400
Received: from qproxy.gmail.com ([72.14.204.206]:57479 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932184AbVJTPbC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 11:31:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aFAqpgw2OeUIDeqLyUi7csapecz9AfdL8uKeKAUOPaxrZKiUn9AL7xoZMsH9TbiTKZdEaKD1GNG7GyfVk8TTX8B6EeH0yJkrlYPvmQGO4sxbUtzdM7KKzOT3876VFCwB3new60RsvdTrvltEx9o/bB+LgHDBM0ZhyjVkFmMtIPc=
Message-ID: <132d4af90510200831p2750709el8a8765ed8f9e38cb@mail.gmail.com>
Date: Thu, 20 Oct 2005 11:31:01 -0400
From: Sachin Kulkarni <write2sck@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kdb patch
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to remotely debug the arm linux kernel on a Intel XScale board.
I am currently using kernel 2.6. Which version/patch of kdb should I
use for the same?

Thanks,
Sachin
