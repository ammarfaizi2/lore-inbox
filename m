Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbUKWLEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbUKWLEu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 06:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUKWLEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 06:04:50 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:25842 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262464AbUKWLEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 06:04:49 -0500
From: Amon Ott <ao@rsbac.org>
Organization: RSBAC
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: towards dynamic resource quotas
Date: Tue, 23 Nov 2004 12:04:41 +0100
User-Agent: KMail/1.6.2
References: <Pine.LNX.4.53.0411230035350.28029@andrew.triumf.ca>
In-Reply-To: <Pine.LNX.4.53.0411230035350.28029@andrew.triumf.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411231204.43800.ao@rsbac.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 23. November 2004 10:25, Andrew Daviel wrote:
> Is there any mechanism within Linux to limit the fraction of a 
resource
> (CPU, memory, network bandwidth) which may be allocated to a 
particular
> process or UID ? If not, perhaps there should be. The idea being to
> ensure that critical tasks can always run, regardless of resource
> depletion by other tasks

The Class-based Kernel Resource Management (CKRM) project at 
http://ckrm.sourceforge.net/ works on this.

Amon.
-- 
http://www.rsbac.org - GnuPG: 2048g/5DEAAA30 2002-10-22
