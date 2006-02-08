Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWBHQ2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWBHQ2d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWBHQ2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:28:33 -0500
Received: from mail.suse.de ([195.135.220.2]:16537 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030344AbWBHQ2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:28:33 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: CONFIG_UNWIND_INFO
Date: Wed, 8 Feb 2006 17:28:22 +0100
User-Agent: KMail/1.8.2
Cc: "Andrew Morton" <akpm@osdl.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org
References: <43E0719F020000780000FAF6@emea1-mh.id2.novell.com> <20060201005324.2c19d78c.akpm@osdl.org> <43EA268A.76F0.0078.0@novell.com>
In-Reply-To: <43EA268A.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602081728.22726.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 17:12, Jan Beulich wrote:
> Attached an updated patch, disallowing the option for all architectures that have been determined to potentially have
> problems with the resulting relocations. Jan

Looks good to me.

-Andi
