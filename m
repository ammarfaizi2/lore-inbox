Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVCFEQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVCFEQn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 23:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVCFEQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 23:16:43 -0500
Received: from smtpout02-04.prod.mesa1.secureserver.net ([64.202.165.194]:52640
	"HELO smtpout02-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S261294AbVCFEQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 23:16:42 -0500
Message-ID: <422A8434.5050107@starnetworks.us>
Date: Sat, 05 Mar 2005 21:16:52 -0700
From: "Kevin P. Fleming" <kpfleming@starnetworks.us>
Organization: Star Networks, LLC
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [request for inclusion] Filesystem in Userspace
References: <E1D6YPJ-0000Jv-00@dorka.pomaz.szeredi.hu> <20050302123123.3d528d05.akpm@osdl.org>
In-Reply-To: <20050302123123.3d528d05.akpm@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> - cachefs is a bit stuck because it's a ton of complex code and afs is
>   the only user of it.  Wiring it up to NFS would help.

Yes, please! I have an application for CacheFS between an NFS client and 
  server (all Linux) very soon :-)
