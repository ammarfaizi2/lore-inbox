Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbVK2MbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbVK2MbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 07:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbVK2MbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 07:31:10 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:10659
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751343AbVK2MbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 07:31:08 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] shared mounts: save mount flag space
Date: Tue, 29 Nov 2005 06:30:17 -0600
User-Agent: KMail/1.8
Cc: Miklos Szeredi <miklos@szeredi.hu>, linuxram@us.ibm.com,
       viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
References: <E1EfJfC-00016e-00@dorka.pomaz.szeredi.hu> <E1EfK2o-0001AK-00@dorka.pomaz.szeredi.hu> <20051126215509.073cb957.akpm@osdl.org>
In-Reply-To: <20051126215509.073cb957.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511290630.17568.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 November 2005 23:55, Andrew Morton wrote:
> The proposed new mount options should be documented somewhere.

Yeah, busybox mount would like to implement them when this all calms down.

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
