Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266309AbUANO3e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 09:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266315AbUANO3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 09:29:34 -0500
Received: from ip5.searssiding.com ([216.54.166.5]:34945 "EHLO
	texas.encore.com") by vger.kernel.org with ESMTP id S266309AbUANO3d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 09:29:33 -0500
Message-ID: <4005524A.F0A7041C@compro.net>
Date: Wed, 14 Jan 2004 09:29:30 -0500
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-ert i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VM_AREA size
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What would the ramifications be of increasing VM_AREA size in
include/asm-i386/page.h from 128mb to 256mb. What would be the proper way to
increase this if the above isn't? 

Regards
Mark
