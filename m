Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbTDMSdg (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 14:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbTDMSdg (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 14:33:36 -0400
Received: from gate.in-addr.de ([212.8.193.158]:7063 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261374AbTDMSdf (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 14:33:35 -0400
Date: Sun, 13 Apr 2003 20:32:23 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Benefits from computing physical IDE disk geometry?
Message-ID: <20030413183222.GA1318@marowsky-bree.de>
References: <200304131407_MC3-1-3441-57C7@compuserve.com> <20030413182405.GG676@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030413182405.GG676@gallifrey>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-04-13T19:24:05,
   "Dr. David Alan Gilbert" <gilbertd@treblig.org> said:

> Now given these discs have processors on board isn't it about time
> someone improved the disc interface standards to push some of the
> intelligence drivewards?  I guess with enough intelligence the drive
> could do free block allocation and could do things like copying blocks
> around for you.

Ah, you have reinvented SCSI (which can copy without involving the host...),
or reinvented the Object Based Storage (see Lustre).


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
