Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266020AbTBGQ0Y>; Fri, 7 Feb 2003 11:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266038AbTBGQ0Y>; Fri, 7 Feb 2003 11:26:24 -0500
Received: from ns.investici.org ([213.140.29.37]:54930 "EHLO
	astio.investici.org") by vger.kernel.org with ESMTP
	id <S266020AbTBGQ0X>; Fri, 7 Feb 2003 11:26:23 -0500
Message-ID: <3E43ED99.2060003@autistici.org>
Date: Fri, 07 Feb 2003 17:32:09 +0000
From: c1cc10 <c1cc10@autistici.org>
Reply-To: c1cc10@autistici.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Cyrix III processor and kernel boot problem
References: <3E43C79A.2010506@autistici.org> <20030207141052.GA22687@codemonkey.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> Which gcc did you use? And (silly question), did you make mrproper
> before building the cyrix3 kernel ? If there were left behind .o
> files, that could confuse it. Possibly ccache too.
> if you were using that rm -rf ~/.ccache to be sure.

ok, I'll jump directly to the point: I did not make any mrproper.
after your answer I tried and it worked.
sorry for the false alarm

c1cc10
-- 
pub  1024D/76A9AC52 2002-12-13 ciunociciunozero (PORCODIO) <c1cc10@ecn.org>
      Key fingerprint = 64A9 9498 B297 B49F D676  AAA1 9DA9 CABA 76A9 AC52
sub  2048g/F248FA79 2002-12-13 [expires: 2004-12-12]


