Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316797AbSF0MFE>; Thu, 27 Jun 2002 08:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSF0MFD>; Thu, 27 Jun 2002 08:05:03 -0400
Received: from candeias.terra.com.br ([200.176.3.18]:57811 "EHLO
	candeias.terra.com.br") by vger.kernel.org with ESMTP
	id <S316782AbSF0MFC>; Thu, 27 Jun 2002 08:05:02 -0400
Date: Thu, 27 Jun 2002 09:05:26 +0000
From: Felipe W Damasio <felipewd@terra.com.br>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MCE Error - 2.5.24 - Whats this?
Message-Id: <20020627090526.137cd7ef.felipewd@terra.com.br>
In-Reply-To: <1025068858.5090.1.camel@coredump>
References: <1025068858.5090.1.camel@coredump>
X-Mailer: Sylpheed version 0.7.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jun 2002 01:20:57 -0400
Shawn Starr <spstarr@sh0n.net> wrote:

SS> MCE: The hardware reports a non fatal, correctable incident occured on
SS> CPU 0.
SS> Bank 0: 9409c00000000136

	This looks like a data cache L2 read error.

Felipe
