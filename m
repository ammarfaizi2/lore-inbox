Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbTDEAi7 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 19:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbTDEAi7 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 19:38:59 -0500
Received: from jalon.able.es ([212.97.163.2]:51593 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id S261533AbTDEAi5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 19:38:57 -0500
Date: Sat, 5 Apr 2003 02:50:20 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] AT_PLATFORM on HT-P4
Message-ID: <20030405005020.GA11904@werewolf.able.es>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva> <20030405004327.GA11141@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030405004327.GA11141@werewolf.able.es>; from jamagallon@able.es on Sat, Apr 05, 2003 at 02:43:27 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


On 04.05, J.A. Magallon wrote:
> 
> On 04.04, Marcelo Tosatti wrote:
> > 
> > So here goes -pre7. Hopefully the last -pre.
> > 
> > Please try it.
> > 

This makes P4 Xeon to report correct i686 platform. Without this, 
all those people that think its ld.so automatically picks i686 libs
are wrong...

-- 
J.A. Magallon <jamagallon@able.es>        \        Software is like sex:
werewolf.able.es                           \  It's better when it's free
Mandrake Linux release 9.2 (Bamboo) for i586
Linux 2.4.21-pre6-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))

--cWoXeonUoKmBZSoM
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="15-binfmt-stack.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWU+2T4AAALZfgAIwS3///+/n3gC/79/zQAK7s7Ocymq4aESek08o001NpHlD
yh6mTEGjQBtR6nlBpoNQmk9DKNqGJoNAAAAAAAAGp5TSApsmmp6nlGmTTRoAADQAAAJTUmIa
FPJPU2mUniJ6h6gbUyAeoGmgDyikMJwbw6yg4Z+qR8Rc5EKD0QCsWU1BZ/TDpTS2SgoT01XF
xMmEi6qfEf7IR5OYBpIy5HN8TsK79p+EYpheIWgwbTkM0ngmE9MtdvCRjoeEOjii0w06Rhwh
oswBAiJIl/OMvGJ3MdbRFU1KH+lQndmax5kSpxnoYrg5bguvIiIimm2nw2dKAcoO+QjpQElL
fBiITOCzgw3VoILk94STVCHVLr86ddua1gmTN1MyNI5zFz6621+Bdnm8UmJdCTnTiEI6Dhds
hyrSZ9BuaJwMQrRgI2kh5iPBQOR4zVxEcBTwiv4RyA0G2UMOdr4mDNOET8EYTfMCHSahD6ag
UMrXoE3SYxrH8yRvig5AslxCUYAXEDB6gRlQXPXMi5vkVkr4P1q8w+F2CodXuFiyAJBALEVW
5d42w3QzKNf7cdHalubQ3UQf1hyUAUbQNoMzMwr0I+hvgx3TxkxSbxeWupPODUc7uMPfGrJg
H8O03zG+xWlTx5mxKRouLMSRXhehyKGMayHcxZx7ebHlhnWCp3DwQCVpYxGMZOhgjBbrMCxk
kyb0OKlS3ciMOU75EcSxAXNiwGoi8HuZ1s1Qop3pdYpO6Wjoz4KUS3TqzocWvZ6IGRotzMJ+
u5gNmi8tRPoZp7ZjCZ97x07ASvEtUNDAEG3EERPOlqghEMSDI0zoOogFXbRRZSOg0GL7m3bH
MBPRrpzPZJCS6b3zKE3XwMr2IpmVxERrnDwcz0cbgWeXIwsCbRLgBNaFHGbobGm01hlKuV3O
Zh+uFOHeiLXB1j2nhCTEouKpjEkxtsYChbQIyZhRFBTDyXWQ6HKTIfQaZQclCGFtYWJA/i7k
inChIJ9snwA=

--cWoXeonUoKmBZSoM--
