Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261962AbSIYPHy>; Wed, 25 Sep 2002 11:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbSIYPHy>; Wed, 25 Sep 2002 11:07:54 -0400
Received: from mailer.psp.ucl.ac.be ([130.104.83.246]:41647 "EHLO
	guppy.psp.ucl.ac.be") by vger.kernel.org with ESMTP
	id <S261962AbSIYPHq>; Wed, 25 Sep 2002 11:07:46 -0400
Mime-Version: 1.0
Message-Id: <p05100318b9b782c06839@[130.104.83.120]>
Date: Wed, 25 Sep 2002 17:12:55 +0200
To: linux-kernel@vger.kernel.org
From: Bernard Paris <Bernard.Paris@psp.ucl.ac.be>
Subject: error compiling kernel 2.4.19
Cc: bernard.paris@psp.ucl.ac.be
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



aic7xxx_old/aic7xxx_seq.c:693: parse error before `+'
aic7xxx_old/aic7xxx_seq.c:734: `aic7xxx_patch3_func' undeclared here 
(not in a function)
aic7xxx_old/aic7xxx_seq.c:734: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:734: (near initialization for 
`sequencer_patches[3].patch_func')
aic7xxx_old/aic7xxx_seq.c:734: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:734: (near initialization for `sequencer_patches[3]')
aic7xxx_old/aic7xxx_seq.c:735: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:735: (near initialization for `sequencer_patches[4]')
aic7xxx_old/aic7xxx_seq.c:736: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:736: (near initialization for `sequencer_patches[5]')
aic7xxx_old/aic7xxx_seq.c:737: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:737: (near initialization for `sequencer_patches[6]')
aic7xxx_old/aic7xxx_seq.c:738: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:738: (near initialization for `sequencer_patches[7]')
aic7xxx_old/aic7xxx_seq.c:739: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:739: (near initialization for `sequencer_patches[8]')
aic7xxx_old/aic7xxx_seq.c:740: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:740: (near initialization for `sequencer_patches[9]')
aic7xxx_old/aic7xxx_seq.c:741: `aic7xxx_patch3_func' undeclared here 
(not in a function)
aic7xxx_old/aic7xxx_seq.c:741: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:741: (near initialization for 
`sequencer_patches[10].patch_func')
aic7xxx_old/aic7xxx_seq.c:741: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:741: (near initialization for 
`sequencer_patches[10]')
aic7xxx_old/aic7xxx_seq.c:742: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:742: (near initialization for 
`sequencer_patches[11]')
aic7xxx_old/aic7xxx_seq.c:743: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:743: (near initialization for 
`sequencer_patches[12]')
aic7xxx_old/aic7xxx_seq.c:744: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:744: (near initialization for 
`sequencer_patches[13]')
aic7xxx_old/aic7xxx_seq.c:745: `aic7xxx_patch3_func' undeclared here 
(not in a function)
aic7xxx_old/aic7xxx_seq.c:745: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:745: (near initialization for 
`sequencer_patches[14].patch_func')
aic7xxx_old/aic7xxx_seq.c:745: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:745: (near initialization for 
`sequencer_patches[14]')
aic7xxx_old/aic7xxx_seq.c:746: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:746: (near initialization for 
`sequencer_patches[15]')
aic7xxx_old/aic7xxx_seq.c:747: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:747: (near initialization for 
`sequencer_patches[16]')
aic7xxx_old/aic7xxx_seq.c:748: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:748: (near initialization for 
`sequencer_patches[17]')
aic7xxx_old/aic7xxx_seq.c:749: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:749: (near initialization for 
`sequencer_patches[18]')
aic7xxx_old/aic7xxx_seq.c:750: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:750: (near initialization for 
`sequencer_patches[19]')
aic7xxx_old/aic7xxx_seq.c:751: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:751: (near initialization for 
`sequencer_patches[20]')
aic7xxx_old/aic7xxx_seq.c:752: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:752: (near initialization for 
`sequencer_patches[21]')
aic7xxx_old/aic7xxx_seq.c:753: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:753: (near initialization for 
`sequencer_patches[22]')
aic7xxx_old/aic7xxx_seq.c:754: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:754: (near initialization for 
`sequencer_patches[23]')
aic7xxx_old/aic7xxx_seq.c:755: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:755: (near initialization for 
`sequencer_patches[24]')
aic7xxx_old/aic7xxx_seq.c:756: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:756: (near initialization for 
`sequencer_patches[25]')
aic7xxx_old/aic7xxx_seq.c:757: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:757: (near initialization for 
`sequencer_patches[26]')
aic7xxx_old/aic7xxx_seq.c:758: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:758: (near initialization for 
`sequencer_patches[27]')
aic7xxx_old/aic7xxx_seq.c:759: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:759: (near initialization for 
`sequencer_patches[28]')
aic7xxx_old/aic7xxx_seq.c:760: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:760: (near initialization for 
`sequencer_patches[29]')
aic7xxx_old/aic7xxx_seq.c:761: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:761: (near initialization for 
`sequencer_patches[30]')
aic7xxx_old/aic7xxx_seq.c:762: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:762: (near initialization for 
`sequencer_patches[31]')
aic7xxx_old/aic7xxx_seq.c:763: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:763: (near initialization for 
`sequencer_patches[32]')
aic7xxx_old/aic7xxx_seq.c:764: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:764: (near initialization for 
`sequencer_patches[33]')
aic7xxx_old/aic7xxx_seq.c:765: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:765: (near initialization for 
`sequencer_patches[34]')
aic7xxx_old/aic7xxx_seq.c:766: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:766: (near initialization for 
`sequencer_patches[35]')
aic7xxx_old/aic7xxx_seq.c:767: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:767: (near initialization for 
`sequencer_patches[36]')
aic7xxx_old/aic7xxx_seq.c:768: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:768: (near initialization for 
`sequencer_patches[37]')
aic7xxx_old/aic7xxx_seq.c:769: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:769: (near initialization for 
`sequencer_patches[38]')
aic7xxx_old/aic7xxx_seq.c:770: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:770: (near initialization for 
`sequencer_patches[39]')
aic7xxx_old/aic7xxx_seq.c:771: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:771: (near initialization for 
`sequencer_patches[40]')
aic7xxx_old/aic7xxx_seq.c:772: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:772: (near initialization for 
`sequencer_patches[41]')
aic7xxx_old/aic7xxx_seq.c:773: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:773: (near initialization for 
`sequencer_patches[42]')
aic7xxx_old/aic7xxx_seq.c:774: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:774: (near initialization for 
`sequencer_patches[43]')
aic7xxx_old/aic7xxx_seq.c:775: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:775: (near initialization for 
`sequencer_patches[44]')
aic7xxx_old/aic7xxx_seq.c:776: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:776: (near initialization for 
`sequencer_patches[45]')
aic7xxx_old/aic7xxx_seq.c:777: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:777: (near initialization for 
`sequencer_patches[46]')
aic7xxx_old/aic7xxx_seq.c:778: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:778: (near initialization for 
`sequencer_patches[47]')
aic7xxx_old/aic7xxx_seq.c:779: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:779: (near initialization for 
`sequencer_patches[48]')
aic7xxx_old/aic7xxx_seq.c:780: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:780: (near initialization for 
`sequencer_patches[49]')
aic7xxx_old/aic7xxx_seq.c:781: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:781: (near initialization for 
`sequencer_patches[50]')
aic7xxx_old/aic7xxx_seq.c:782: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:782: (near initialization for 
`sequencer_patches[51]')
aic7xxx_old/aic7xxx_seq.c:783: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:783: (near initialization for 
`sequencer_patches[52]')
aic7xxx_old/aic7xxx_seq.c:784: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:784: (near initialization for 
`sequencer_patches[53]')
aic7xxx_old/aic7xxx_seq.c:785: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:785: (near initialization for 
`sequencer_patches[54]')
aic7xxx_old/aic7xxx_seq.c:786: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:786: (near initialization for 
`sequencer_patches[55]')
aic7xxx_old/aic7xxx_seq.c:787: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:787: (near initialization for 
`sequencer_patches[56]')
aic7xxx_old/aic7xxx_seq.c:788: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:788: (near initialization for 
`sequencer_patches[57]')
aic7xxx_old/aic7xxx_seq.c:789: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:789: (near initialization for 
`sequencer_patches[58]')
aic7xxx_old/aic7xxx_seq.c:790: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:790: (near initialization for 
`sequencer_patches[59]')
aic7xxx_old/aic7xxx_seq.c:791: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:791: (near initialization for 
`sequencer_patches[60]')
aic7xxx_old/aic7xxx_seq.c:792: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:792: (near initialization for 
`sequencer_patches[61]')
aic7xxx_old/aic7xxx_seq.c:793: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:793: (near initialization for 
`sequencer_patches[62]')
aic7xxx_old/aic7xxx_seq.c:794: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:794: (near initialization for 
`sequencer_patches[63]')
aic7xxx_old/aic7xxx_seq.c:795: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:795: (near initialization for 
`sequencer_patches[64]')
aic7xxx_old/aic7xxx_seq.c:796: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:796: (near initialization for 
`sequencer_patches[65]')
aic7xxx_old/aic7xxx_seq.c:797: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:797: (near initialization for 
`sequencer_patches[66]')
aic7xxx_old/aic7xxx_seq.c:798: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:798: (near initialization for 
`sequencer_patches[67]')
aic7xxx_old/aic7xxx_seq.c:799: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:799: (near initialization for 
`sequencer_patches[68]')
aic7xxx_old/aic7xxx_seq.c:800: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:800: (near initialization for 
`sequencer_patches[69]')
aic7xxx_old/aic7xxx_seq.c:801: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:801: (near initialization for 
`sequencer_patches[70]')
aic7xxx_old/aic7xxx_seq.c:802: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:802: (near initialization for 
`sequencer_patches[71]')
aic7xxx_old/aic7xxx_seq.c:803: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:803: (near initialization for 
`sequencer_patches[72]')
aic7xxx_old/aic7xxx_seq.c:804: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:804: (near initialization for 
`sequencer_patches[73]')
aic7xxx_old/aic7xxx_seq.c:805: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:805: (near initialization for 
`sequencer_patches[74]')
aic7xxx_old/aic7xxx_seq.c:806: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:806: (near initialization for 
`sequencer_patches[75]')
aic7xxx_old/aic7xxx_seq.c:807: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:807: (near initialization for 
`sequencer_patches[76]')
aic7xxx_old/aic7xxx_seq.c:808: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:808: (near initialization for 
`sequencer_patches[77]')
aic7xxx_old/aic7xxx_seq.c:809: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:809: (near initialization for 
`sequencer_patches[78]')
aic7xxx_old/aic7xxx_seq.c:810: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:810: (near initialization for 
`sequencer_patches[79]')
aic7xxx_old/aic7xxx_seq.c:811: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:811: (near initialization for 
`sequencer_patches[80]')
aic7xxx_old/aic7xxx_seq.c:812: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:812: (near initialization for 
`sequencer_patches[81]')
aic7xxx_old/aic7xxx_seq.c:813: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:813: (near initialization for 
`sequencer_patches[82]')
aic7xxx_old/aic7xxx_seq.c:814: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:814: (near initialization for 
`sequencer_patches[83]')
aic7xxx_old/aic7xxx_seq.c:815: initializer element is not constant
aic7xxx_old/aic7xxx_seq.c:815: (near initialization for 
`sequencer_patches[84]')
make[3]: *** [aic7xxx_old.o] Error 1
make[3]: Leaving directory `/usr/local/src/linux-2.4.19/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/local/src/linux-2.4.19/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/local/src/linux-2.4.19/drivers'
make: *** [_dir_drivers] Error 2
