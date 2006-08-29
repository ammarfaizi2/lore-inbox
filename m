Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWH2OdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWH2OdL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWH2OdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:33:11 -0400
Received: from cantor2.suse.de ([195.135.220.15]:4519 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964993AbWH2OdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:33:09 -0400
From: Andi Kleen <ak@suse.de>
To: "Dong Feng" <middle.fengdong@gmail.com>
Subject: Re: The 3G (or nG) Kernel Memory Space Offset
Date: Tue, 29 Aug 2006 16:32:55 +0200
User-Agent: KMail/1.9.3
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Paul Mackerras" <paulus@samba.org>,
       "Christoph Lameter" <clameter@sgi.com>,
       "David Howells" <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <a2ebde260608290715o627c631uca67e5b84b8c0777@mail.gmail.com>
In-Reply-To: <a2ebde260608290715o627c631uca67e5b84b8c0777@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608291632.55077.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 August 2006 16:15, Dong Feng wrote:
> The Linux kernel permenantly map 3-4G linear memory space to 0-4G

i386 Mainline kernel doesn't, no.

-Andi
