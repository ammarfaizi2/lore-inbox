Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbRERJxe>; Fri, 18 May 2001 05:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262290AbRERJxY>; Fri, 18 May 2001 05:53:24 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:58597 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S262289AbRERJxM>; Fri, 18 May 2001 05:53:12 -0400
Message-ID: <3B04ED94.9F42C17D@TeraPort.de>
Date: Fri, 18 May 2001 11:38:28 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: ReiserFs: Cosmetic problem in linux/Documentation/Changes [2.4.x]
In-Reply-To: <3B04E9E4.16ED592B@TeraPort.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I submitted this a short while ago, only to realize later that the
subject line was not very informative. Sorry.

 As a suggestion: maybe the reiser-tools should support the common
-V/--version flag

Martin

"Martin.Knoblauch" wrote:
> 
> Hi,
> 
>  apparently the method to find out the version of the reiserfs[progs]
> mentioned in above file does not produce any result at all.
> 
> # reiserfsck 2>&1|grep reiserfsprogs
> 
>  reports nothing. If I look at the output "manually", there does not
> seem to be any version in there.
> 
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
IT Services              |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
