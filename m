Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136496AbREIOgS>; Wed, 9 May 2001 10:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136499AbREIOgI>; Wed, 9 May 2001 10:36:08 -0400
Received: from host-64-65-206-13.choiceone.net ([64.65.206.13]:24872 "EHLO
	isaiah.tpr-east.com") by vger.kernel.org with ESMTP
	id <S136496AbREIOfz>; Wed, 9 May 2001 10:35:55 -0400
Message-ID: <3AF9558F.9C76953C@tpr.com>
Date: Wed, 09 May 2001 10:34:55 -0400
From: Mark Bratcher <bratcher@tpr.com>
Organization: Torrey Pines Research
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ATAPI Tape Driver Failure in Kernel 2.4.4
Content-Type: multipart/mixed;
 boundary="------------29ABB5C20748E793E24EAF0A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------29ABB5C20748E793E24EAF0A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I just upgraded from kernel 2.2.17 to 2.4.4. I use a Seagate ATAPI tape drive,
model STT20000A. I use dump to do backups (probably not relevant).

In version 2.2.17 kernel, backups worked fine. In 2.4.4, I get the following
error message:

ide-tape: bh == NULL in idetape_copy_stage_to_user.

Anyone know what causes this problem?

Please reply directly, as I'm not a member of this list.

Thanks :-)
Mark Bratcher
--------------29ABB5C20748E793E24EAF0A
Content-Type: text/x-vcard; charset=us-ascii;
 name="bratcher.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Mark Bratcher
Content-Disposition: attachment;
 filename="bratcher.vcf"

begin:vcard 
n:Bratcher;Mark
tel;fax:716/288-4604
tel;work:716/288-7220
x-mozilla-html:FALSE
url:www.tpr.com
org:Torrey Pines Research
version:2.1
email;internet:bratcher@tpr.com
title:Director of Software Development
adr;quoted-printable:;;565 Blossom Road=0D=0ASuite A;Rochester;New York;14610;USA
x-mozilla-cpt:;19472
fn:Bratcher, Mark
end:vcard

--------------29ABB5C20748E793E24EAF0A--

