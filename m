Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVDRT0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVDRT0B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVDRT0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:26:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30857 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262172AbVDRTZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:25:54 -0400
Date: Mon, 18 Apr 2005 15:25:32 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] procfs privacy:  /proc/config.gz
In-Reply-To: <1113850319.17341.79.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0504181525180.11251@chimarrao.boston.redhat.com>
References: <1113850319.17341.79.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="=-+pKyBmVu/gi+jYQutaqM"
Content-ID: <Pine.LNX.4.61.0504181525181.11251@chimarrao.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--=-+pKyBmVu/gi+jYQutaqM
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.61.0504181525182.11251@chimarrao.boston.redhat.com>

On Mon, 18 Apr 2005, Lorenzo Hernández García-Hierro wrote:

> This patch changes the permissions of the procfs entry config.gz, thus, 
> non-root users are restricted from accessing it.

Why?

What is the security benefit of doing this ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
--=-+pKyBmVu/gi+jYQutaqM--
