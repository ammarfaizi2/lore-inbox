Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbUCRRRH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 12:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbUCRRRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 12:17:07 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:36744 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262791AbUCRRRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 12:17:04 -0500
Subject: Re: Active defragmentation : A replacement for bigphysarea?
From: Dave Hansen <haveblue@us.ibm.com>
To: Alok Mooley <rangdi@yahoo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040317173607.31415.qmail@web9706.mail.yahoo.com>
References: <20040317173607.31415.qmail@web9706.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1079630221.5789.1906.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Mar 2004 09:17:01 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-17 at 09:36, Alok Mooley wrote:
> I have implemented a memory defragmentation utility
> for linux kernel 2.6 based on the paper by Mr. Daniel
> Phillips.
> Can this utility be used instead of the bigphysarea
> patch, for requirements less than MAX_ORDER of
> allocation ?
> Can the people using the bigphysarea patch kindly
> provide me with their respective memory requirements.

Have you incorporated any of the suggestions from the last time that you
posted the patch?   Could you post the current version?

-- dave

