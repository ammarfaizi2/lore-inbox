Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965318AbVKGXAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965318AbVKGXAM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965590AbVKGXAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:00:11 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:2792 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S965318AbVKGXAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:00:09 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/3][Resend] swsusp: simplifications and cleanups
Date: Mon, 7 Nov 2005 23:53:33 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz
References: <200511020000.11183.rjw@sisk.pl> <20051104150458.04ad3439.akpm@osdl.org>
In-Reply-To: <20051104150458.04ad3439.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511072353.34091.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series of patches implements some simplifications
and cleanups of swsusp.

The patches have been redone against 2.6.14-mm1, as requested.

Greetings,
Rafael

